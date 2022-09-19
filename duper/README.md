# Duper

## performance

10:

```powershell
(base) PS C:\Users\chris\IdeaProjects\learn-elixir\duper> Measure-Command { mix run --no-halt > dups.txt }


Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 16
Milliseconds      : 866
Ticks             : 168663634
TotalDays         : 0.000195212539351852
TotalHours        : 0.00468510094444444
TotalMinutes      : 0.281106056666667
TotalSeconds      : 16.8663634
TotalMilliseconds : 16866.3634
```

5:

```powershell
(base) PS C:\Users\chris\IdeaProjects\learn-elixir\duper> Measure-Command { mix run --no-halt > dups.txt }


Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 16
Milliseconds      : 230
Ticks             : 162300378
TotalDays         : 0.000187847659722222
TotalHours        : 0.00450834383333333
TotalMinutes      : 0.27050063
TotalSeconds      : 16.2300378
TotalMilliseconds : 16230.0378
```

2:

```powershell
(base) PS C:\Users\chris\IdeaProjects\learn-elixir\duper> Measure-Command { mix run --no-halt > dups.txt }


Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 24
Milliseconds      : 505
Ticks             : 245055814
TotalDays         : 0.000283629414351852
TotalHours        : 0.00680710594444444
TotalMinutes      : 0.408426356666667
TotalSeconds      : 24.5055814
TotalMilliseconds : 24505.5814
```

20:

```powershell
(base) PS C:\Users\chris\IdeaProjects\learn-elixir\duper> Measure-Command { mix run --no-halt > dups.txt }


Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 16
Milliseconds      : 363
Ticks             : 163639554
TotalDays         : 0.000189397631944444
TotalHours        : 0.00454554316666667
TotalMinutes      : 0.27273259
TotalSeconds      : 16.3639554
TotalMilliseconds : 16363.9554
```
