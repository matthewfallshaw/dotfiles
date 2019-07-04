function git-pull-subdirectories -d "`git pull` all subdirectories of pwd"
  echo 'Pulling subdirectories...'
  set -l start_dir (pwd)
  for d in (ls -d */)
    echo $d
    cd $d
    if test -d .git
      git pull
    else
      echo "Not a git repo"
    end
    cd $start_dir
    echo
    echo
    echo
  end
  and echo 'Finished.'
end
