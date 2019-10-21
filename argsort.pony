primitive ArgSort[A: Seq[C] ref, C: Comparable[C] #read, B: Seq[D] ref, D: Any #read]
  """
  The same as the Sort method from the collections package, but accepts two Arrays. It's like argsort in
  python, as we sort the first array by its contents we sort the indices in the second array at the same time
  """
  fun apply(a: A, b: B) =>
    """
    Sort the given seq.
    """
    try _argsort(a, b, 0, a.size().isize() - 1)? end

  fun _argsort(a: A, b: B, lo: ISize, hi: ISize) ? =>
    if hi <= lo then return end
    // choose outermost elements as pivots
    if a(lo.usize())? > a(hi.usize())? then _swap(a, b, lo, hi)? end
    (var p, var q) = (a(lo.usize())?, a(hi.usize())?)
    // partition according to invariant
    (var l, var g) = (lo + 1, hi - 1)
    var k = l
    while k <= g do
      if a(k.usize())? < p then
        _swap(a, b, k, l)?
        l = l + 1
      elseif a(k.usize())? >= q then
        while (a(g.usize())? > q) and (k < g) do g = g - 1 end
        _swap(a, b, k, g)?
        g = g - 1
        if a(k.usize())? < p then
          _swap(a, b, k, l)?
          l = l + 1
        end
      end
      k = k + 1
    end
    (l, g) = (l - 1, g + 1)
    // swap pivots to final positions
    _swap(a, b, lo, l)?
    _swap(a, b, hi, g)?
    // recursively sort 3 partitions
    _argsort(a, b, lo, l - 1)?
    _argsort(a, b, l + 1, g - 1)?
    _argsort(a, b, g + 1, hi)?

  fun _swap(a: A, b: B, i: ISize, j: ISize) ? =>
    a(j.usize())? = a(i.usize())? = a(j.usize())?
	b(j.usize())? = b(i.usize())? = b(j.usize())?
