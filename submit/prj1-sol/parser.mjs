#!/usr/bin/env node

import fs from 'fs';
import Path from 'path';

function parse(text) {
  const tokens = scan(text);
  let index = 0;
  let lookahead = nextToken();
  const value = program();
  return value;

  function peek(kind) { return (lookahead[0] === kind) ? true : false; }

  function match(kind) {
    if (peek(kind)) {
      lookahead = nextToken();
    }
    else {
      console.error(`expecting ${kind} at ${lookahead.kind}`);
      process.exit();
    }
  }

  function nextToken() {
    return (
      (index >= tokens.length) ? tokens.push(['EOF', '<EOF>']) : tokens[index++]
    );
  }

  function program() {
    const asts = [];
    while (!peek('EOF')) {
      asts.push(...source());
      match(lookahead[0]);
    }
    return asts;
  }

  function source() {
    let result = [];
    while(peek('TEXT') || peek('IFDEF') || peek('IFNDEF')) {
      let kind = lookahead[0];
      let lexeme = lookahead[1];
      
      if (kind === 'TEXT') {
	match(kind);
        result.push(new AstText(lexeme)); 
      }
      else {
        const i1 = ifdef();
	result.push(i1);
      }
    }
    return result;
  }

  function ifdef() {
    let tag, sym, kids; 

    let kind = lookahead[0];
    if (kind === 'IFDEF' || kind === 'IFNDEF') {
      tag = kind;
      match(kind);
      
      kind = lookahead[0];
      const lexeme = lookahead[1];
      match(kind);
      sym = lexeme;
    }

    kids = source();
    
    while(peek('ELIF')) {
      match('ELIF');

      kind = lookahead[0];
      const lexeme = lookahead[1];
      match(kind);
      kids.push(new Ast('ELIF', lexeme, ...source()));
    }
    
    kind = lookahead[0];
    if (kind === 'ELSE') {
      match(kind);
      kids.push(new Ast(kind, null, ...source()));
    }

    match('ENDIF');

    return (new Ast(tag, sym, ...kids));
  }

}

function scan(input) {
  let text = "";
  const tokens = [];

  input = input.split('\n');
  input.pop();
  while (input.length > 0) {
    let m;
    if ((m = input[0].match(/^\s*[a-zA-Z]+/))) {
      let newText = m.input + '\n';
      text = text.concat(newText);
    }
    else if ((m = input[0].match(/^\s*\#i[a-zA-Z]+|\#e[a-zA-Z]+/))) {
      if (text.length > 0) {
        tokens.push(['TEXT', text]); 
        text = "";
      }
      
      let directive = m[0].trim();
      tokens.push([directive.slice(1).toUpperCase(), directive]);
      if (directive == '#ifdef' || directive == '#ifndef' || directive == '#elif') {
        let str = m.input.trim().split(' ')[1];
	if (str && (m = str.match(/^[_a-zA-Z]\w*/))) tokens.push(['SYM', m[0]]);
      }
    }
    else {
    	m = input[0].match(/^\s*.*|\s*/);
	if (m) {
          let newText = m.input + '\n'
          text = text.concat(newText);
	}
    }

    input = input.slice(1);
  }

  if (text.length > 0) {
    tokens.push(['TEXT', text]); 
    text = "";
  }
  
  return tokens;
}

const CHAR_SET = 'utf8';
function main() {
  const text = fs.readFileSync(0, CHAR_SET);
  const value = parse(text);
  console.log(JSON.stringify(value));
}

class AstText {
  constructor(TXT) {
    Object.assign(this, {tag: "TEXT", text: TXT});
  }
}

class Ast {
  constructor(tag, sym, ...kids) {
    if (sym != null) Object.assign(this, {tag, sym, xkids: kids});
    else Object.assign(this, {tag, xkids: kids});
  }
}
main();
