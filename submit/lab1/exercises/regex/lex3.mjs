export default {
  $Ignore: /\s+|\/\/.*[^.]/,  //this will be ignored.
  INT: /\d+/,      //token with kind INT  
  ID: /[_a-zA-Z][_a-zA-Z0-9]*/,      
  CHAR: /./,       //single char: must be last; 
  				  // /./ is a regex which matches any char other than '\n'

};
