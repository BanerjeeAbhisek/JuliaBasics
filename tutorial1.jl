# Julia comments use #, like Python/R

# Variables — no type declarations needed
n = 10
name = "experiment A"
pi_ish = 3.14

# Printing
println("Running $name with n=$n")   # $ 

# Arrays — like Python lists / R vectors, written with []
ages = [25, 30, 35, 40, 45]
scores = [88.5, 92.0, 79.5, 95.0, 83.0]

# Indexing — remember: 1-based!
println(ages[1])      # first element -> 25
println(ages[end])    # last element -> 45  (Julia's "end" keyword, handy)

# Slicing
println(ages[2:4])    # elements 2 through 4 -> [30, 35, 40]

# Whole-array math is "broadcast" with a dot
println(ages .+ 1)    # adds 1 to every element -> [26, 31, ...]does string interpolation, like Python f-strings

import Pkg
Pkg.add("DataFrames")

using DataFrames

df = DataFrame(age = ages, score = scores, group = ["A", "B", "A", "B", "A"])
println(df)


# Rows where score is above 85
high = filter(row -> row.score > 85, df)
println(high)

# Or the macro style (often more readable) - needs DataFramesMeta, skip for now
# Boolean indexing also works, very R-like:
df[df.score .> 85, 1:2]


using Statistics   # for mean, if not already loaded

grouped = groupby(df, :group)              # split by the 'group' column
result = combine(grouped, :score => mean)  # apply mean to score in each group
println(result)


combine(grouped, :score => mean, :score => maximum, nrow)

import Pkg
Pkg.add("Plots")
using Plots

# Simple line/scatter
scatter(df.age, df.score, label="scores", xlabel="age", ylabel="score")


# Bar chart of the group means we computed
result = combine(groupby(df, :group), :score => mean => :avg)
bar(result.group, result.avg, label="mean score", title="Average by group")

# Histogram
histogram(scores, bins=5, label="score distribution")

# Add to an existing plot with the ! convention
scatter(df.age, df.score, label="data")
plot!(df.age, df.score, label="trend")   # plot! modifies the current plot

scatter(df.age, df.score, label="scores")
savefig("myplot.png")

#git add .
#git commit -m "your message here"
#git push
