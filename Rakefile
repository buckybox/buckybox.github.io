desc "Deploy build directory to GitHub Pages"
task :deploy do
  cd __dir__ do
    run_or_fail "[ -z \"$(git status -s)\" ]"
    run_or_fail "git checkout dev"

    puts "## Building website..."
    run_or_fail "middleman build --verbose"

    puts "## Syncing website..."
    run_or_fail "[ ! -e /tmp/build ]"
    run_or_fail "rsync -av --remove-source-files build /tmp/"
    run_or_fail "git checkout master"
    run_or_fail "rsync -av --delete --exclude .git --remove-source-files /tmp/build/ ."
    run_or_fail "rm -rfv /tmp/build"

    message = "Site updated at #{Time.now.utc}"
    puts "\n## Commiting: #{message}"
    run_or_fail "git add -A"
    run_or_fail "git commit -m \"#{message}\""

    puts "\n## Pushing generated website..."
    run_or_fail "git push origin master"

    puts "\n## Deploy complete"

    run_or_fail "git checkout dev"
  end
end

def run_or_fail cmd
  system(cmd) || fail("Command `#{cmd}' failed.")
end
