use std::env;
use std::fs;
use std::path::{Path, PathBuf};

fn main() {
    let args: Vec<String> = env::args().collect();

    let og_path = Path::new(&args[1]);

    let to_directory = Path::new(&args[2]);

    let og_file = fs::read_to_string(og_path).expect("Should have been able to read the file");

    let file_name = og_path.file_name().expect("source must have a file name");

    let mut target_path = PathBuf::from(to_directory);

    target_path.push(file_name);

    fs::write(target_path, og_file).expect("wrote the file")
}
