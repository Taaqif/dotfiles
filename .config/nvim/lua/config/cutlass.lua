local cutlass_ok, cutlass = pcall(require, "cutlass")
if not cutlass_ok then
  return
end

cutlass.setup({
  cut_key = 'x',
  exclude = { "ns", "nS" },
})
