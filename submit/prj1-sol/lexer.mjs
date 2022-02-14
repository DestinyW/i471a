#!/usr/bin/env node

import fs from 'fs';
import Path from 'path';

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
  const tokens = scan(text);
  console.log(tokens);
}

main();
