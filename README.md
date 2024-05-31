# [Overthewire Solutions](https://overthewire.org/wargames/)

## The Rules

First thing first, ensure to always comply with the [**rules**](https://overthewire.org/rules/) of the wargames

## Why does this repository exists?

While solving the first challenge, bandit, I had a hard time finding two things:

1.	Quality solutions
2.	Hints to solve the challenge instead of the solution given right away

This is because of this lack that I decided to record what I learned in this Github Repository

## What should you expect to find in this repository?

The name is pretty self-explanatory, you'll find the solutions to the Overthewire Wargames.
However, even though you'll find the solutions, the documentation will also include some commonly 
encountered difficulties and some hints before unveilling the solution so that any person that comes 
here looking for advice without being spoiled the solution can do so without any fear.

## But Chary, what are the overthewire wargames?

Let's ask ChatGPT to describe the wargames:

OverTheWire is a platform offering a variety of cybersecurity wargames designed to teach and improve hacking and security skills through hands-on practice. These challenges cover a broad range of topics from basic command-line skills to advanced exploitation techniques. Each wargame is divided into levels, and each level presents a unique challenge that needs to be solved to progress to the next. The platform is ideal for learners at various stages, providing a structured learning path in a safe and legal environment.
General Overview of OverTheWire Challenges:

### Purpose
-	To teach and enhance cybersecurity skills.
-	To provide practical experience with various hacking techniques.
-	To offer a structured and progressively challenging learning environment.

### Structure
-	Challenges are divided into different wargames, each focusing on specific aspects of cybersecurity.
-	Each wargame consists of multiple levels, with each level requiring the player to solve a particular problem or exploit a vulnerability to retrieve a password or key to progress to the next level.

### Learning Outcomes
-	Mastery of basic to advanced Linux command-line skills.
-	Understanding of binary exploitation and reverse engineering.
-	Familiarity with web application security vulnerabilities.
-	Knowledge of cryptographic principles and methods.
-	Experience with real-world cybersecurity scenarios and problem-solving techniques.

### Popular Wargames on OverTheWire
-	Bandit: Focuses on basic Linux command-line skills, file manipulation, and introductory scripting.
-	Leviathan: Introduces basic binary exploitation and reverse engineering concepts.
-	Narnia: Delves deeper into binary exploitation, including stack overflows and format string vulnerabilities.
-	Natas: Focuses on web application security, covering common web vulnerabilities such as SQL injection and XSS.
-	Krypton: Introduces cryptographic principles and challenges involving various types of ciphers.
-	Vortex: Offers advanced binary exploitation and reverse engineering challenges for more experienced players.

Each wargame is designed to be educational, providing a step-by-step progression from simpler to more complex challenges, allowing players to build their skills incrementally. The platform is widely used by cybersecurity enthusiasts, students, and professionals to practice and refine their hacking abilities in a controlled and educational setting.


## What now ?

Now, you can let me walk you through the solutions of the first challenge, [bandit](https://overthewire.org/wargames/bandit/).
The solutions are available [here](/bandit/README.md)

### About the man reader

During the walkthrough, I'll highlight the information that is to be retrieved inside the man pages using a custom-made tool called *man reader*. As it's name may indicate, I use it to navigate sections of man pages more easily and to not print all of them at the same time. The tool has been written in bash when I decided to make a personnal project to help me learn bash (I was also complaining a lot that peole don't read man pages enough and that is why I decided to make a tool that helps me view man pages more easily). The use of this tool comes with a few prerequisites:

To use it you need:
-	to be under bash version >=4 (which means not to be on an Apple computer because for god knows which reason they decided to ship computers up to today with bash version 3.2 installed)
-	to not be on Asahi Linux (because for colouring they didn't implement the deprecated `termcaps` which I found a lot easier to use than the `terminfo` library).

You can run `bash --version` to check  the version of bash you're using.
You can also go [there](https://github.com/Charystag/man_reader.git) to learn more about the project

### Alternative

If the man reader doesn't work for any reason, or if you think you don't need a software that splits the man pages for you, you could still benefit from using a lighter script called `colored_man`. It still works with the termcaps library but only adds colored to the traditionnally white man page.<br/>
To use it, you have two options :
1.	Getting the script and then sourcing it in your current environment :
```bash
wget https://raw.githubusercontent.com/Charystag/Scripts/main/colored_man.sh && . colored_man.sh
```
You can then run the command `man` as usual to run the commands

2.	Running the script directly from the repository :

```bash
curl -fsSL --connect-timeout 10 https://raw.githubusercontent.com/Charystag/Scripts/main/colored_man.sh | bash -s
```

You can directly add your man page at the end of the command. For example, instead of running `man bash` you'll run `curl -fsSL --connect-timeout 10 https://raw.githubusercontent.com/Charystag/Scripts/main/colored_man.sh | bash -s bash`


## Must Read

Here are a selection of ressources gathered on the internet on how to ask for help. This might be very useful, be it during the challenges or during any other stage of your learning journey so ensure you read it thoroughly, even if you didn't learn a thing it will at the very least remind you that RTFM is not an indicator of rudeness, but an invitation to autonomy.

- [How To Ask Questions The Smart Way](http://catb.org/~esr/faqs/smart-questions.html) *A reference* **informative** *document about how to ask questions*
- [How do I ask a good question?](https://stackoverflow.com/help/how-to-ask) *A Stackoverflow blogpost on how to ask a question on the forum*
- [How to debug small programs](https://ericlippert.com/2014/03/05/how-to-debug-small-programs/) *A blogpost about autonomy in debugging before asking questions*

## Useful Ressources

- [Challenge Status](https://status.overthewire.org/) *A link that indicates all the overthewire challenges that are down, if it's green then you need to try harder*
