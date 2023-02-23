/**
* @param {Number} n number to make into string
* @param {Number} sf significant figures of output
* @param {Boolean} add_suffix whether to add a letter suffix
* @param {String} suffix_lb The lower bound of the divisor (IE "M" do not go lower than millions)
* @param {Boolean} format whether to reduce the magnitude when formatting
* @param {String} magnitude If the magnitude is known apriori this can be used to override the factoring
* @param {Boolean} add_commas Format the numeric string output with commas every thousands place.
* @returns {String} formatted axis label
*/

function num2str ({n, sf = 2, add_suffix = false, suffix_lb = "", format = true, magnitude = null, add_commas = false} = {}) {
  
  var suf_is_string = typeof add_suffix == 'string';
  var do_magnitude = magnitude !== false
  var o = undefined;
  if (!is_null(n)) {
    if (format) {
      if (suf_is_string && add_suffix == '%') {
        if (is_likely_perc(n)) {
          o = n * 100;
        } else {
          o = parseFloat(n);
        }
      } else {
        var suf = ["", "K", "M", "B"];
        var out = [];
        for (var i = 0; i < suf.length; i++) {
          // test multiples of 1000
          out.push(n / (10 ** (i * 3)));
        }
        if (magnitude !== null) {
          var i = suf.indexOf(magnitude)
          o = out[i]
          // index of the lowest suffix requested
          var lb = suf.indexOf(suffix_lb);
        } else if (do_magnitude) {
          out = out.map(Math.abs);
          // Which multiple of one thousand as the divisor results in a number above 1
          var o = Math.min(...out.filter((a) => {return a>=1;}));
          // The index of the suffix
          i = out.indexOf(o);
          // index of the lowest suffix requested
          lb = suf.indexOf(suffix_lb);
          // Replace infinity with 0
          o = isFinite(o) ? o : 0.0;
        }
      }
     
      
      if (!suf_is_string && i > lb && do_magnitude) {
        // Convert to decimal with string suffix abbreviation format
        o = (o * Math.sign(n))
        .toFixed(sf);
        // Exclude decimals from this logic that removes everything after the decimal
        if (o >= 1 || o == 0 || o <= -1) {
          o = o.replace(/[^\.]+0+$/gm, "")
          .replace(/\.$/gm, "");
        }
        if (add_suffix) {
          add_suffix = suf[i]; 
        } 
      } else {
        // otherwise just format for humans
        o = sigFig(n, sf = sf);
      }
    } 
  } else {
    var o = 'NA';
  }
  
  
  
  if (typeof add_suffix == 'string') {
     o = o.toLocaleString() + add_suffix;
  } else {
    if (typeof o == 'number') {
      o = o.toLocaleString();
    }
  }
  if (add_commas) {
    o = addCommas(o);
  }
  
return o;
}
  