alias dz := dev-zeus
alias dt := dev-term

default:
  just --list

dev-zeus:
  @cd zeus && cargo run

dev-term:
  @cd hermes && cargo build && printf "\n"
  echo "Build successful hermes"
  echo ""
  ./hermes/target/debug/hermes

fmt:
  #!/usr/bin/env bash
  for project in zeus hermes; do
    cd $project
    cargo fmt
    cd ..
  done

rust_release_file_size:
  #!/usr/bin/env bash
  for project in zeus hermes; do
    size=$(cd $project && ls -alih target/release/$project | awk '{print $6}')
    echo "Size of $project := $size"
  done


_build_projects:
  @echo "Building Hermes..."
  @cd hermes && cargo build --release
  @echo "Hermes Built Successfully"
  @echo "Building Zeus..."
  @cd zeus && cargo build --release
  @echo "Zeus Built Successfully..."

# To build all the components of zeus
build: _build_projects && rust_release_file_size 
