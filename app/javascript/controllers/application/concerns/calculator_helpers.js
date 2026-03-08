export function parseEuro(v) {
  // accepts: 5000, "5000", "5000.2", "5.000,20", "€5,000.20"
  if (v == null) return 0;

  let s = String(v).trim();

  // keep digits, comma, dot, minus
  s = s.replace(/[^\d.,-]/g, "");

  // If both '.' and ',' exist: decide which is decimal by last occurrence
  const lastDot = s.lastIndexOf(".");
  const lastComma = s.lastIndexOf(",");
  if (lastDot !== -1 && lastComma !== -1) {
    const decimalIsComma = lastComma > lastDot;
    if (decimalIsComma) {
      // "1.234,56" -> remove thousands dots, turn comma into dot
      s = s.replace(/\./g, "").replace(",", ".");
    } else {
      // "1,234.56" -> remove thousands commas
      s = s.replace(/,/g, "");
    }
  } else if (lastComma !== -1) {
    // only comma: treat as decimal separator
    s = s.replace(",", ".");
  }

  const n = Number(s);
  return Number.isFinite(n) ? n : 0;
}

export function humanizeEuro(euro) {
  const n = parseEuro(euro);

  var tot = new Intl.NumberFormat("hr-HR", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(n);

  return `${tot}€`
}

/**
 * Round Half-Even (Banker's Rounding)
 * https://en.wikipedia.org/wiki/Rounding#Round_half_to_even
 */
export function financialRoundUp(value, d = 2) {
  const n0 = Number(value);
  if (!Number.isFinite(n0)) return 0;

  const m = Math.pow(10, d);
  const n = +(d ? n0 * m : n0).toFixed(8);

  const i = Math.floor(n);
  const diff = n - i;
  const e = 1e-8;

  const r =
    diff > 0.5 - e && diff < 0.5 + e
      ? (i % 2 === 0 ? i : i + 1)
      : Math.round(n);

  return d ? r / m : r;
}

export function percentHumanize(value) {
  return `${value*100}%`
}

export function euroToCent(value) {
  return value*100
}

export function percentToRatio(value) {
  return value/100
}

export function ratioToPercent(value) {
  return value*100
}


