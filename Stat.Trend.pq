let func =  
 // fnStat.Trend
// Author: Imke Feldmann - http://www.thebiccountant.com/ - Link to blogpost: http://wp.me/p6lgsG-Fd

(Actuals as table, FCPeriods as list) =>
let
    FCPeriods = Table.FromList(FCPeriods, Splitter.SplitByNothing()),
    #"Run R Script" = R.Execute("y <- as.matrix(Actuals[1]) 
                                 x <- as.matrix(Actuals[2])
                                 trendline <- fitted(lm(y ~ x))
                                 forecast <- predict(lm(y ~ x), list(x = as.matrix(FCPeriods)))
                                 outTrendline <- cbind(Actuals, data.frame(trendline))
                                 outForecast <- cbind(FCPeriods, data.frame(forecast))"
                                 ,[Actuals=Actuals, FCPeriods=FCPeriods]),
    RStatTrend = #"Run R Script"
in
    RStatTrend
, documentation = [
Documentation.Name =  " fnRStat.Trend
", Documentation.Description = " R-function for trend (fitted(lm) and forecast (predict(lm)
", Documentation.Category = " R Statistical Functions
", Documentation.Author = " Imke Feldmann: www.TheBIccountant.com
", Documentation.Examples = {[Description =  " 1) Choose table with actual figures 2) choose column holding the forecast periods
" , Code = " Check this blogpost explaining how it works: http://wp.me/p6lgsG-Fd
 ", Result = " 
"]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
