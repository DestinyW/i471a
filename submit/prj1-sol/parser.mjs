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

  function nextToken() { return (index >= tokens.length) ? tokens.push(['EOF', '<EOF>']) : tokens[index++]; }

  function source() {
    let result = [];
    while(peek('TEXT') || peek('IFDEF') || peek('IFNDEF')) {
      const kind = lookahead[0];
      const value = lookahead[1];
      match(kind);
      if (kind === 'TEXT') { 
	const ast = new Ast('TEXT');
	ast.text = value;    
        result.append(ast); 
      }
      else {
	const res = ifdef();
	result.push(res);
      }
    }
    return result;
  }

  function ifdef() {
    let result = [];

    let kind = lookahead[0];
    if (kind === 'IFDEF' || kind == 'IFNDEF') { 
      match(kind);

      const value = lookahead[1];
      match('SYM');
      const ast = new Ast(kind, source());
      ast.sym = value;
      //ast.xkids = source();
      result.append(ast);
    }

    while(peek('ELIF')) {
      kind = lookahead[0];
      match(kind);
      
      const value = lookahead[1];
      match('SYM');
      const ast = Ast(kind, source());
      ast.sym = value;
      result.append(ast);
    }  
    
    kind = lookahead[0];
    if (kind === 'ELSE') {
      const ast = new Ast(kind, source());
      result.append(ast);
    }

    return result;
  }

}


function scan(input) {
  let text = "";
  const tokens = [];

  input = input.split('\n');
  while (input.length > 0) {
    let m;
    if ((m = input[0].match(/^\s+/))) {
      // ignore whitespace
    }
    else if ((m = input[0].match(/^[a-zA-Z]+/))) {
      text.concat(' ', m);
    }
    else {
      m = input[0].match(/^\#/);

      if (text.length > 0) {
        tokens.push(['TEXT', text]);
        text = "";
      }

      directive = m.split(' ')[0];
      if (directive.length < 2) text.concat(' ', m);
      else {
	tokens.push([directive.slice(1).toUpperCase(), directive]);
        if (directive == '#ifdef' || directive == '#ifndef' || directive == '#elif') {
          for (const str of m.split(' ')) {
	    let s;
	    if ((s = str.match(/^[_a-zA-Z]\w*/))) tokens.push(['SYM', s]);
	  }
	}
      }
    }

    input = input.slice(1);
  }
  return tokens;
}


const CHAR_SET = 'utf8';
function main() {
  const text = fs.readFileSync(0, CHAR_SET);
  const value = parse(text);
  console.log(JSON.stringify(value));
}

class Ast {
  constructor(tag, ...kids) {
    Object.assign(this, {tag, xkids: kids});
  }
}
main();
