
/**
* @param {Number} n number to make into string
* @param {Number} sf significant figures of output
*/

function num2str (n, sf = 2) {

function is_null (x) {
  return x === null;
}
      if (!is_null(n)) {
        var suf = ["", "K", "M", "B"];
        var out = [];
        for (var i = 1; i < 4; i++) {
          out.push(n / (10 ** (i * 3)));
        }
        out = out.map(Math.abs);
        var o = Math.min(...out.filter((a) => {return a>=1;}));
        i = out.indexOf(o) + 1;
        if (isFinite(o)) {
          o = (o * Math.sign(n))
          .toFixed(sf)
          .replace(/[^\.]+0+$/gm, "")
          .replace(/\.$/gm, "")
          o = o + suf[i]
        }  else {
          o = n.toLocaleString()
        }
      } else {
        var o = 'NA'
      }

  return o;
}
