import csv
import os

CODE_DEPS_CSV = "code_deps.csv"
KNOWLEDGE_DEPS_CSV = "knowledge_deps.csv"
OUTPUT_CSV = "inconsistencies_found.csv"

def analyze():
    print("Loading code dependencies (Module analysis)...")
    static_deps = set()
    
    try:
        with open(CODE_DEPS_CSV, 'r', encoding='utf-8') as f:
            # read standard csv
            reader = csv.reader(f, delimiter=',')
            next(reader) 
            for row in reader:
                if len(row) >= 2:
                    # extract module name
                    nome_file_src = os.path.basename(row[0].strip().replace('\\', '/'))
                    nome_file_tgt = os.path.basename(row[1].strip().replace('\\', '/'))
                    
                    src_mod = os.path.splitext(nome_file_src)[0].lower()
                    tgt_mod = os.path.splitext(nome_file_tgt)[0].lower()
                    static_deps.add((src_mod, tgt_mod))
                    
        print(f" -> Loaded {len(static_deps)} dependencies between modules.")
    except FileNotFoundError:
        print("ERROR: file code_deps.csv non found!")
        return

    print("Crossing code and knowledge dependencies...")
    inconsistencies = []
    
    try:
        with open(KNOWLEDGE_DEPS_CSV, 'r', encoding='utf-8') as f:
            f.seek(0)
            
            reader = csv.reader(f, delimiter=',')
            next(reader)
            
            for row in reader:
                if len(row) < 4: 
                    continue 
                
                # source_a and source_b contains the paths extracted from CodeScene
                source_a, source_b = row[0].strip(), row[1].strip()
                degree, revisions = row[2].strip(), row[3].strip()

                # Extract module's name
                name_a = os.path.basename(source_a.replace('\\', '/'))
                name_b = os.path.basename(source_b.replace('\\', '/'))

                mod_a = os.path.splitext(name_a)[0].lower()
                mod_b = os.path.splitext(name_b)[0].lower()

                # Is there any code dependency between modules A and B?
                has_ab = (mod_a, mod_b) in static_deps
                has_ba = (mod_b, mod_a) in static_deps

                # If there isn't code dependency, it's an inconsistency
                if not has_ab and not has_ba:
                    # save result
                    inconsistencies.append([source_a, source_b, degree, revisions])
                    
    except FileNotFoundError:
        print("ERROR: file knowledge_deps.csv not found!")
        return

    print(f"Saving results...")
    with open(OUTPUT_CSV, 'w', newline='', encoding='utf-8') as f:
        # Generate output csv
        writer = csv.writer(f, delimiter=',')
        writer.writerow(["File_A", "File_B", "Temporal_Coupling", "Shared_Revisions"])
        writer.writerows(inconsistencies)

    print(f" -> Found {len(inconsistencies)} inconsistencies.")
    print(f" -> Results saved in: {OUTPUT_CSV}")

if __name__ == "__main__":
    analyze()