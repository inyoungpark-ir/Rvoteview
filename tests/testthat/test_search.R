library(Rvoteview)
context('Query voteview database with string, download vote metadata')

test_that('search function hits database', {
  expect_that(voteview.search('test'), not(throws_error()))
})

test_that('search function options query leela correctly', {
  expect_that(voteview.search('Iraq', startdate = 2014), not(throws_error("cannot open the connection")))
  expect_that(voteview.search('Iraq', startdate = '2014-10-01'), not(throws_error("cannot open the connection")))
  expect_that(voteview.search('Iraq', enddate = '2014-10-01'), not(throws_error("cannot open the connection")))
  expect_that(voteview.search('Iraq', chamber = "House"), not(throws_error("cannot open the connection")))
})

test_that('search function input validation works', {
  expect_that(voteview.search(''), throws_error('No votes found'))
})

test_that('search function returns example dataframe with correct number of votes', {
  df <- voteview.search('rhodesia')
  df_sub <- voteview.search('rhodesia', startdate = 1970)
  
  expect_is(df, 'data.frame')
  expect_is(df_sub, 'data.frame')
  expect_equal(nrow(df), 32)
  expect_equal(nrow(df_sub), 31)
  expect_is(df_sub$id, "character")
  expect_identical(length(unique(df_sub$id)), nrow(df_sub))
})