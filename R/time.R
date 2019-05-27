# make sure not to make calls too often

# get time of last call
get_gnapi_time <-
function()
{
   last <- as.numeric(Sys.getenv("GNapi_time"))
   ifelse(is.na(last), 0, last)
}

# set gnapi time to current
set_gnapi_time <-
function() {
    Sys.setenv(GNapi_time = as.numeric(Sys.time()))
}

# time since last call
time_since_gnapi <-
function() {
    as.numeric(Sys.time()) - get_gnapi_time()
}

# check for last time since call, and delay if necessary
# also re-set the gnapi_time
delay_if_necessary <-
function()
{
    # look for delay amount in options; otherwise set to default
    delay_amount <- getOption("GNapi_delay")
    if(is.null(delay_amount)) {
        delay_amount <- 1
    }

    if((timesince = time_since_gnapi()) < delay_amount) {
        Sys.sleep(delay_amount - timesince)
    }

    set_gnapi_time()
}
