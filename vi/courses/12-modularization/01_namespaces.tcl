# Exercise: Namespaces
# 1. Create a namespace for timing analysis.
# 2. Export specific commands.
# 3. Test namespace isolation.

namespace eval TimingAnalyzer {
    namespace export check_slack report
    
    variable violations 0

    proc check_slack {slack} {
        variable violations
        if {$slack < 0} {
            incr violations
            return "VIOLATED"
        }
        return "MET"
    }

    proc report {} {
        variable violations
        puts "Timing violations found: $violations"
    }
}

puts "--- Using Namespace directly ---"
puts "Slack -0.5: [TimingAnalyzer::check_slack -0.5]"
puts "Slack 1.2: [TimingAnalyzer::check_slack 1.2]"
TimingAnalyzer::report

puts "\n--- Importing Namespace ---"
namespace import TimingAnalyzer::*
puts "Slack -0.1: [check_slack -0.1]"
report
