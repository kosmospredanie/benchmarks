function matgen(n)
  tmp = 1.0 / n / n
  [ tmp * (i - j) * (i + j - 2) for i=1:n, j=1:n ]
end

function mul(a, b)  
  m,n = size(a)
  q,p = size(b)
  out = zeros(promote_type(eltype(a), eltype(b)),m,p)
  for j = 1:p
    for i = 1:m
      z = zero(eltype(out))   
      for k = 1:n
        z += a[i,k]*b[k,j]
      end
      out[i,j] = z
    end
  end
  out
end

function main(n)
  t = time()
  n = round(Int, n / 2 * 2)
  a = matgen(n)
  b = matgen(n)
  c = mul(a, b)
  v = round(Int, n/2) + 1
  println(c[v, v])
  println(time() - t)
end

function test()
  n = 100
  if length(ARGS) >= 1
    n = parse(Int, ARGS[1])
  end

  println(STDERR, "warming")
  main(200)

  println(STDERR, "bench")
  x = @timed main(n)
  println(STDERR, "Elapsed: $(x[2]), Allocated: $(x[3]), GC Time: $(x[4])")
end

test()
