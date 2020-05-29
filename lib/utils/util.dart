String stockDescription(int stock) {
  if (stock == 0)
    return '\u274c Out of stock';
  else if (stock < 200)
    return '\u26a0 Low stock';
  else
    return '\u2714 Sufficient stock';
}
