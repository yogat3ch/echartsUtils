/**
* @param {Number} n value to round
* @param {Number} sf Significant figures to round to
* @returns {String} formatted axis label
*/
function sigFig(n, sf = 0) {
    if (typeof n == 'string') {
      if (n == 'NA' || n == 'NaN') {
        return 'NA'
      }
      n = parseFloat(n.replace(/,/g, ''));
    }
    var log10 = Math.log10(Math.abs(n)) || 1;
    if ((n > 1 || n < -1) && Boolean(n - Math.floor(n))) {
      // Numbers with decimal places
      var out = n.toPrecision(log10 + 1 + sf);
    } else if ((n < 1 && n > 0) || (n < 0 && n > -1)) {
      // Decimals
      var out = n.toPrecision(1);
    } else if (n == 0) {
      var out = n;
    } else {
      // Numbers without decimal places
      var out = n.toPrecision(log10 + 1);
    }
  
     return out;
  }
  