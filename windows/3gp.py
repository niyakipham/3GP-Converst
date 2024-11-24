
import os
import subprocess

def convert_mp4_to_3gp(output_dir="3gp"):
    """Converts all .mp4 files in the current directory to .3gp format."""

    # Ensure the output directory exists
    os.makedirs(output_dir, exist_ok=True)

    # Counter for numbering 3gp files
    counter = 1

    # Iterate over all files in the current directory
    for filename in os.listdir():
        # Check if the file is an mp4 file
        if filename.endswith(".mp4"):
            # Create output filename
            output_file = os.path.join(output_dir, f"{counter}.3gp")

            # Construct the ffmpeg command
            command = [
                "ffmpeg",
                "-y",  # Overwrite output file without asking
                "-i", filename,
                "-r", "20",
                "-s", "352x288",
                "-vb", "400k",
                "-acodec", "aac",
                "-strict", "experimental",  # Allow experimental codecs
                "-ac", "1",
                "-ar", "8000",
                "-ab", "24k",
                output_file
            ]

            # Execute the ffmpeg command
            subprocess.run(command, check=True) #check=True raises an exception if the command fails

            # Increment the counter
            counter += 1

    print(f"Conversion complete. 3gp files saved in '{output_dir}' directory.")

# Call the function to perform the conversion
convert_mp4_to_3gp()