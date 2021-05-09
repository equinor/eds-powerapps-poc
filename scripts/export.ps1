Remove-Item exports -Force
mkdir exports
pac solution export --path exports\solution.zip --name JOS_CA_ActivityPlanner --managed false --include general