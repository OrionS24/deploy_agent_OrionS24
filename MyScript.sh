bash
#!/bin/bash
read -p "Enter input name" input
mkdir attendance_tracker_$input
cd attendance_tracker_$input
mkdir attendance_checker.py
cd attendance_checker.py
mkdir Helpers reports
cd Helpers
touch assets.csv config.json
cd ..
cd reports
touch reports.log
cd ..
CONFIG_FILE="config.json"

echo "Do you want to update the attendance thresholds? (yes/no)"
read choice

if [ "answer" == "yes" ]; then
    read -p "Enter new warning threshold (defaut was 75): " warning
    read -p "Enter new failure threshold (defaut was 50): " failure
    warning=${warning:-75}
    failure=${failure:-50}

    sed -i "s/\Wwarning_threshold\": *[0-9]*\/warning_threshold\": $warning/" $CONFIG_FILE
    sed -i "s/\"failure_threshold\": *[0-9]*/\"failure_threshold\": $failure/" "$CONFIG_FILE"
    echo "Attendance thresholds updated successfully."
else
    echo "Attendance thresholds remain unchanged."
fi

echo "Enter project name or identifier:"
read input

project_dir="attendance_tracker_$input"
archive_name="attendance_tracker_$input.tar.gz"

mkdir -p "$project_dir"
echo "Project directory created: $project_dir"
cleanup(){
    echo ""
    echo "Cleanup in progress..."
    if [ -d "$project_dir" ]; then
       echo "Archiving current project..."
       tar -czf "$archive_name" "$project_dir"
       echo "Archive has been created: $archive_name"
       echo "Deleting incomplete project directory..."
       rm -rf "$project_dir"
       echo "Cleanup completed."
    fi
    exit 1
}
trap cleanup SIGINT
echo "Simulating project setup... Press Ctrl+C to trigger cleanup."
sleep 15

echo "Project setup completed successfully."

project_dir="attendance_tracker_$input"
echo "Running health check"
if python3 --version >/dev/null 2?&1; then
echo "Python3 is installed."
else
echo "Warning: Python3 is not installed."
fi

echo "Health Check Complete."
