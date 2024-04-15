#! /usr/bin/bash

# 1. first copy all submissions from /var/local/lib/cms/submissions to ~
# 2. run this script
# 3. you will get a folder named Problem_Submissions, which groups submissions by problem name

rm -rf Problem_Submissions
IFS=$'\n'

getProblemName(){
    ProblemName=$(head -n 3 $1 | tr -d '\r\n' | tr -cd '[:alnum:]-_}.%' | sed 's/\.%l.*//' | awk -F '}' '{print $NF}')
    echo $ProblemName
}

for team in $(ls submissions); do
    for submission in $(ls submissions/$team); do
        problem=$(getProblemName "submissions/$team/$submission")
        time=$(echo "$submission" | sed 's/ /_/g')
        rename="${team}_${problem}_${time}.cpp"
        
        if [ ! -d "$problem" ]; then
            mkdir -p "Problem_Submissions/$problem"
        fi
        cp "submissions/$team/$submission" "Problem_Submissions/$problem/$rename"

    done
    echo "$team done!"
done
