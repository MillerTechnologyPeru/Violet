echo 'Updating unimplemented builtins...'

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sourcery \
  --sources ./Sources/Objects \
  --templates $script_dir/implemented.stencil \
  --output $script_dir/implemented.py \
  --quiet

python3 $script_dir/list_unimplemented.py > $script_dir/result.txt

echo 'See: ./Scripts/unimplemented_builtins/result.txt'
