import os
import re
import csv

JOLT_SOURCE_FOLDER = "./Jolt"
OUTPUT_CSV = "code_deps.csv"

def extract_static_dependencies():
    print("Scanning source code...")
    include_pattern = re.compile(r'#include\s+["<]([^">]+)[">]')
    static_deps = set()

    for root, _, files in os.walk(JOLT_SOURCE_FOLDER):
        for file in files:
            if file.endswith('.cpp') or file.endswith('.h'):
                filepath = os.path.join(root, file)
                try:
                    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                        for line in f:
                            match = include_pattern.search(line)
                            if match:
                                source_path = filepath.replace('\\', '/')
                                target_path = match.group(1).strip().replace('\\', '/')
                                
                                static_deps.add((source_path, target_path))
                except Exception as e:
                    print(f"Impossible read file {file}: {e}")

    with open(OUTPUT_CSV, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(["SourceFile", "TargetFile"])
        for src, tgt in static_deps:
            writer.writerow([src, tgt])
            
    print(f"Success! Saved {len(static_deps)} code dependencies in {OUTPUT_CSV}")

if __name__ == "__main__":
    extract_static_dependencies()