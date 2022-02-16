#!/usr/bin/env node

import fs from 'fs';
import Path from 'path';

function scan(input) {
  let text = "";
  const tokens = [];

  input = input.split('\n');
  while (input.length > 0) {
    let m;
    if ((m = input[0].match(/^\s*[a-zA-Z]+/))) {
      let newText = m.input + '\n';
      if (text.length < 1) text = newText;
      else text = text.concat(' ', newText);
    }
    else if ((m = input[0].match(/^\s*\#[a-zA-Z]+/))) {
      if (text.length > 0) {
        tokens.push(['TEXT', text]); 
        text = "";
      }
      
      let directive = m[0].trim();
      tokens.push([directive.slice(1).toUpperCase(), directive]);
      if (directive == '#ifdef' || directive == '#ifndef' || directive == '#elif') {
        let str = m.input.trim().split(' ')[1];
	if ((m = str.match(/^[_a-zA-Z]\w*/))) tokens.push(['SYM', m[0]]);
      }
    }
    else {
    	m = input[0].match(/^\s*.*[^.]/);
	if (m) tokens.push(['TEXT', m.input + '\n']);
    }

    input = input.slice(1);
  }

  if (text.length > 0) {
    tokens.push(['TEXT', text]); 
    text = "";
  }
  
  return JSON.stringify(tokens);
}

const CHAR_SET = 'utf8';
function main() {
  const text = fs.readFileSync(0, CHAR_SET);
  const tokens = scan(text);
  console.log(tokens);
  //fs.writeFileSync(1, tokens);
}

main();
