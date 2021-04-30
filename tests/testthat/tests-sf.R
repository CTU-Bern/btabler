

txt <- read.delim(system.file("extdata", "special_characters.txt", package = "btabler"),
                  sep = ",", fileEncoding = "utf-8")

test_that("special characters converted", {
  x <- sf(txt$word)
  expect_equal(x[1], "$\\dagger$ dagger")
  expect_equal(x[2], "$\\ddagger$ doubledagger")
  expect_equal(x[3], "\\\"a a-umlaut")
  expect_equal(x[4], "\\\"A a-umlaut")
  expect_equal(x[5], "\\^{a} a-hat")
  expect_equal(x[6], "\\`{a} a-grav")
  expect_equal(x[7], "\\\"o o-umlaut")
  expect_equal(x[8], "\\\"O O-umlaut")
  expect_equal(x[9], "\\^{o} o-hat")
  expect_equal(x[10], "\\\"u u-umlaut")
  expect_equal(x[11], "\\\"U U-umlaut")
  expect_equal(x[12], "\\c{c} c-cedille")
  expect_equal(x[13], "\\'{e} e-acute")
  expect_equal(x[14], "\\`{e} e-grav")
  expect_equal(x[15], "\\^{e} e-hat")
  expect_equal(x[16], "$\\pm$ pm")
  expect_equal(x[17], "{\\\\textmu} mu")
  expect_equal(x[18], "\\\\textcelsius celcius")
  expect_equal(x[19], "$^\\\\circ$ degree")

})

