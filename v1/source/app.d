module main;

import std.stdio;
import std.math : pow;
import std.algorithm : map, sum;
import line;

void analyzeSavingsPlan(double monthlyDeposit, double annualRate, double totalYears, double intervalYears)
{
    // 1. Create the timeline (e.g., years 2, 4, 6, 8, 10)
    auto timeline = Line(0, totalYears, intervalYears);

    writeln("=== Savings Milestone Report ===");
    writeln("Checkpoints (years): ", timeline);          // InputRange -> [2, 4, 6, 8, 10]
    writeln("Total checkpoints:   ", timeline.length);   // .length -> 5
    writeln("First checkpoint:    Year ", timeline[0]);  // opIndex -> 2
    writeln("Final checkpoint:    Year ", timeline[$ - 1]); // opDollar ($) -> 10
    writeln();

    // Helper formula for future value of monthly deposits
    double balanceAtYear(double years)
    {
        double monthlyRate = annualRate / 12.0;
        double months = years * 12.0;
        return monthlyDeposit * ((pow(1 + monthlyRate, months) - 1) / monthlyRate);
    }

    // 2. Slicing: Inspect only the mid-term milestones (skipping first and last)
    auto midTerm = timeline[1 .. $ - 1]; // opSlice -> [4, 6, 8]
    writeln("Mid-term checkpoints: ", midTerm);
    foreach (yr; midTerm)
    {
        writefln("  Year %.0f -> ₦%.2f", yr, balanceAtYear(yr));
    }
    writeln();

    // 3. Reverse iteration: Countdown from final goal back to start
    writeln("Countdown from final target:");
    foreach_reverse (yr; timeline) // back & popBack
    {
        writefln("  Year %.0f: ₦%.2f", yr, balanceAtYear(yr));
    }
    writeln();

    // 4. std.algorithm integration: Sum of balances across all checkpoints
    double totalAcrossCheckpoints = timeline.map!(yr => balanceAtYear(yr)).sum;
    writefln("Cumulative snapshot value: ₦%.2f", totalAcrossCheckpoints);
}

void main()
{
    // Test: ₦50,000/month at 12% annual interest over 10 years, checked every 2 years
    analyzeSavingsPlan(50_000, 0.12, 10, 2);
}
