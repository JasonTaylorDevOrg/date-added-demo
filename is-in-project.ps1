$issueNodeId = "I_kwDOPQBbD87BvyX6"
$projectId = "PVT_kwDODTq8nc4A-atq"

$query = @'
query($projectId: ID!) {
  node(id: $projectId) {
    ... on ProjectV2 {
      items(first: 100) {
        nodes {
          content {
            ... on Issue {
              id
            }
          }
        }
      }
    }
  }
}
'@

$result = gh api graphql -F projectId=$projectId -f query="$query"
$inProject = $result | Select-String $issueNodeId

if ($inProject) {
    Write-Output "Issue is in project"
} else {
    Write-Output "Issue is NOT in project"
}