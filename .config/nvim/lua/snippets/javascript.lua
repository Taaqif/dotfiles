return {
 s(
    "ust",
    fmt("const [{}, set{setter}] = useState({})", {
      i(1, "value"),
      i(2, "initialValue"),
      setter = l(l._1:sub(1,1):upper() .. l._1:sub(2,-1), 1)
    })
  ),
}
