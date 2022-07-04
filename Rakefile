require 'html-proofer'

desc "Run tests"
task test: %w[build] do
  options = { :assume_extension => true, :log_level => 'error' }
  HTMLProofer.check_directory("./_site", options).run
end

desc "Build the site"
task build: %w[clean] do
  sh "JEKYLL_ENV=production bundle exec jekyll build --drafts"
end

desc "Clean up"
task :clean do
  sh "rm -rf ./_site ./.jekyll-cache ./.jekyll-metadata"
end
