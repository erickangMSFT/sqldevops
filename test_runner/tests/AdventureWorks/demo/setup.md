# Setup to enable slaker unittest framework in CI agent

Slacker requires ruby and ruby devkit as a pre-req for the build and unittest agent.

## Ruby installation 

Install [runby 2.2.6](https://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.2.6-x64.exe)

```bash
# macOS
brew install rbenv
echo eval "$(rbenv init -)" > .bash_profile
source .bash_profile
rbenv install 2.4.1
rbenv global 2.4.1
ruby -v

# windows
ruby_installer.exe -o "c:\Ruby" -y
```

Install [ruby DevKit](https://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe)

```bash
ruby_devkit_installer.exe -o "c:\RubyDevKit" -y
```

- It is a Self-extracting zip file. Create a folder e.g. RubyDevKit and extract devkit files. 
- Add RubyDevKit\bin to PATH.
- Run following commands

```bash
cd rubydevkit
ruby dk.rb init
ruby dk.rb install
```

## Install slacker

```bash
gem install slacker
```

## Running Unittest On Visual Studio 
* nuget install 
    * xunit.runner.visualstudio
    * xunit
    * slacker runner

```bash
git clone 'this project'
cd ${cloned_directory}/adventureworks_unittest
slacker
```

# How to create Database Unittest Project

* Create a Database Project (sqlproj) and solution.
* On the solution, Add new project. Select **Test** category and **Unit Test Project**
* Name the project as **DatabaseUnitTest** for this tutorial 
* Remove following from References
    * Microsoft.VisualStudio.TestPlatfrom.*
* Add following nuget packages
    * SlackerRunner by Orn Kristjansson
    * xunit by James Newkirk, Brad Wilson
    * xunit.runner.visualstudio by James Newkirk, Brad Wilson

## Test runnner template
* Open and replace unittest1.cs with the following code. RunAll test method retrieves all Slacker test specs under the spec folder defined by RUN_TEST_DIR and SPEC_TEST_DIR.

```csharp
using System;
using System.IO;
using System.Collections.Generic;

using SlackerRunner;
using SlackerRunner.Util;
using Xunit;

namespace DatabaseUnittest
{
  
    public class AllTestSpecs
    {
        public static string RUN_TEST_DIR = Path.GetFullPath(Path.Combine("..", "..", "..", "TestSpecs")) + "\\";
        public static string SPEC_TEST_DIR = Path.GetFullPath(Path.Combine("..", "..", "..", "TestSpecs", "spec") + "/");

        [Theory]
        [MemberData("TestFiles", typeof(SpecTestFile))]
        public void RunAll(ISpecTestFile File)
        {
            SlackerResults TestResults = new SlackerService().Run(RUN_TEST_DIR, SPEC_TEST_DIR + File.FileName);
            Assert.True(TestResults.Passed, TestResults.Message);
        }

        /// <summary>
        /// Uses the SpecTesterResolver to figure out all the test files in a directory
        /// </summary>
        public static IEnumerable<object[]> TestFiles(Type type)
        {
            // Pass either SpecTestFile to run tests in a group or IndividualTestFile to run one test file at a time 
            List<ISpecTestFile> files = SpecsTesterResolver.ProcessDirectory(SPEC_TEST_DIR, type);

            // Back to caller
            foreach (ISpecTestFile file in files)
                yield return new object[] { file };
        }
    }
}
``` 

* Open Test Explorer in Visual Studio and execute Run All. You will see DatabaseUnitTest.AllTestSpecs.RunAll method is successfully discovered and executed with a failure. We haven't defined any test specs yet. Let's create test specs.

## Create TestSpecs project 

* TestSpecs project is a project placeholder for our Slacker test specs. 
* For the simplicity, we will use C# Class Library project type.

* In the Solution Explorer, run **Add | New Project**.
* Select **Visual C# | Windows Classic Desktop | Empty Project**. Name the project as **TestSpecs**. 

* Open Solution Properties and got to **Configuration Properties | Configuration**

* Turn off 'Build' on TestSpecs project.

* Open terminal.

* CD to the solution directory

* Run following to create a new Slacker project in TestSpec folder.

```bash
slacker_new TestSpecs
```

## Git Clone Sample

* git clone https://github.com/erickangMSFT/dbunittest-slacker

* Copy following from git repository to the TestSpec folder in Visual Studio and add to TestSpec project.
* Add following to TestSpecs project in Visual Studio from TestSpecs folder

    * data
    * lib
    * spec
    * sql
    * database.yml

* Open database.yml and update the server, database and sql login properties to make a connection. Consider security protection with database.yml file and its connection properties.

## Run Tests

* In Test Explorer in VS, Run All and see all tests are enabled and executed successfully.