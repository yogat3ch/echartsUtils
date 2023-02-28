function sigFig_length(x) {
  return (x + "").split(".")[1].length;
}
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
      var precision = log10 + sf
      if (sigFig_length(n) > sf) {
        precision += 1
      }
      var out = n.toPrecision(precision);
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
  