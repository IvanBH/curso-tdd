use Test;

use Project::Data::JSON;
use Project::Stored;
use Project::Issue;

my $data-file = "resources".IO ~~ :d
        ?? "resources/data.json"
        !! "../resources/data.json";

my $dator = Project::Data::JSON.new($data-file);
my $stored = Project::Stored.new($dator);
say $stored.data();

my $project-name = $stored.project-name;
my $issue-id=33;
my $milestone = Project::Milestone.new(:$project-name,:milestone-id(33));
    for (Open,Closed) -> $state {
        my $issue = Project::Issue.new( :$project-name, :$issue-id );
        $issue.close() if $state == Closed;
        $milestone.new-issue( $issue );
        $issue-id++;
    }
done-testing;