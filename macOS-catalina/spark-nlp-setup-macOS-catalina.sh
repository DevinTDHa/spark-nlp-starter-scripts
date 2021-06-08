#!/bin/sh
# if there are any problems, refer to
# https://medium.com/spark-nlp/introduction-to-spark-nlp-installation-and-getting-started-part-ii-d009f7a177f3

echo "Starting Spark NLP Installation script."

echo "\nChecking for brew"
which -s brew
if [[ $? != 0 ]] ; then
    echo "\nPlease install homebrew, the package manager for macOS: https://brew.sh/"
else
    echo "brew update"
    brew update
fi


install_openjdk() {
    echo "\nInstalling openjdk@8"
    brew install openjdk@8
    echo "Creating symlink /usr/local/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk"
    sudo ln -sfn /usr/local/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk
    echo "Please add this line to your shell configuration (~/.zshrc):"
    echo "export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-8.jdk/Contents/Home"
}

echo "\nDo you wish to install openjdk-8?
This will create a link in /Library/Java/JavaVirtualMachines/openjdk-8.jdk"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_openjdk; break;;
        No ) echo "\nPlease make sure openjdk-8 is installed and JAVA_HOME is set."; break;;
    esac
done

install_py_venv() {
    echo "Installing in Virtual environment"
    pip3 install virtualenv notebook
    python3 -m virtualenv ./spark-nlp-venv
    source ./spark-nlp-venv/bin/activate
    pip3 install numpy pandas pyspark==3.1.1 spark-nlp==3.0.3 ipykernel
    python -m ipykernel install --user --name spark-nlp --display-name "Spark NLP"
    deactivate
    echo "\nInstallation done! You can now start using Spark NLP in your Jupyter Notebook, by selecting the \"Spark NLP\" kernel."
}

install_py_local() {
    echo "Installing in local Python"
    pip3 install notebook pandas numpy pyspark==3.1.1 spark-nlp==3.0.3
    echo "\nInstallation done! You can now start using Spark NLP in your Jupyter Notebook."
}

echo "\nFor which Python would you like to install Spark NLP?"
select yn in "Local" "Virtual Environment"; do
    case $yn in
        "Local") install_py_local; break;;
        "Virtual Environment") install_py_venv; break;;
    esac
done
