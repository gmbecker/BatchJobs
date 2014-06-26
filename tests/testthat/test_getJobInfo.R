context("getJobInfo")

test_that("getJobInfo", {
  reg = makeTestRegistry()
  batchMap(reg,  function(x, i) x^i, 1:3, i = rep(2, 3))
  mycheck = function(tab) {
    expect_true(is.data.frame(tab))
    expect_equal(tab$id, 1:3)
    expect_true(nrow(tab) == 3)
    expect_true(is(tab$time.submitted, "POSIXt"))
    expect_true(is(tab$time.started, "POSIXt"))
    expect_true(is(tab$time.done, "POSIXt"))
    expect_true(is.numeric(tab$time.queued))
    expect_true(is.numeric(tab$time.running))
    expect_true(all(is.na(tab$error.msg)))
    expect_true(is.integer(tab$r.pid))
    expect_true(is.integer(tab$seed))
  }
  tab = getJobInfo(reg)
  mycheck(tab)
  submitJobs(reg)
  waitForJobs(reg)
  tab = getJobInfo(reg)
  mycheck(tab)

  tab = getJobInfo(reg, ids = integer(0))
  expect_true(is.data.frame(tab))
  expect_true(nrow(tab) == 0L)

  tab = getJobInfo(reg, pars=TRUE)
  expect_equal(tab$X, 1:3)
  expect_equal(tab$i, rep(2, 3))

  tab = getJobInfo(reg, select = "time.running")
  expect_true(ncol(tab) == 2) # id always selected
  expect_true(names(tab)[1] == "id")
  tab = getJobInfo(reg, select = c("id", "time.running"))
  expect_true(ncol(tab) == 2)

  expect_error(
    getJobInfo(reg, select = "fooo"),
    "subset"
  )
})
