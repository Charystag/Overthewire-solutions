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
-	[Bandit](https://overthewire.org/wargames/bandit): Focuses on basic Linux command-line skills, file manipulation, and introductory scripting.
	-	[Walkthrough](/bandit/README.md)
-	Leviathan: Introduces basic binary exploitation and reverse engineering concepts.
-	Narnia: Delves deeper into binary exploitation, including stack overflows and format string vulnerabilities.
-	Natas: Focuses on web application security, covering common web vulnerabilities such as SQL injection and XSS.
-	Krypton: Introduces cryptographic principles and challenges involving various types of ciphers.
-	Vortex: Offers advanced binary exploitation and reverse engineering challenges for more experienced players.

Each wargame is designed to be educational, providing a step-by-step progression from simpler to more complex challenges, allowing players to build their skills incrementally. The platform is widely used by cybersecurity enthusiasts, students, and professionals to practice and refine their hacking abilities in a controlled and educational setting.

## What now ?

Now, you can let me walk you through the solutions of the first challenge, [bandit](https://overthewire.org/wargames/bandit/).
The solutions are available [here](/bandit/README.md)

## Must Read

Here are a selection of ressources gathered on the internet on how to ask for help. This might be very useful, be it during the challenges or during any other stage of your learning journey so ensure you read it thoroughly, even if you didn't learn a thing it will at the very least remind you that RTFM is not an indicator of rudeness, but an invitation to autonomy.

- [How To Ask Questions The Smart Way](http://catb.org/~esr/faqs/smart-questions.html) *A reference* **informative** *document about how to ask questions*
- [How do I ask a good question?](https://stackoverflow.com/help/how-to-ask) *A Stackoverflow blogpost on how to ask a question on the forum*
- [How to debug small programs](https://ericlippert.com/2014/03/05/how-to-debug-small-programs/) *A blogpost about autonomy in debugging before asking questions*

## Useful Ressources

- [Challenge Status](https://status.overthewire.org/) *A link that indicates all the overthewire challenges that are down, if it's green then you need to try harder*
- [Introduction to user commands](https://man7.org/linux/man-pages/man1/intro.1.html)

## Reminder - Cleanup after yourself

For the challenges where you need to work in a temporary directory, you can run the following command : 
```bash
cd $HOME && rm -rf $OLDPWD
```
to remove the contents of the temporary directory you were in.

## On the importance of sourcing

I thought I'd end this README by sharing with you something I learned the hard way : More often than not, it is a pain in the a\*\* to find links to official documentation. 
People seems to find more relevant to link to online tutorials (when then even bother to do so). This statement is not to be taken as a general as there are, 
thankfully, a lot of people that link to official doc.

### Why do I even bother talking about it ?

By including links to official documentation, we ensure trustworthiness, accuracy and we give the opportunity to people to learn more concepts that revolve around the documentation (and that's also a kind way to teach them how to RTFM).

So I hope you'll find all the work here useful, it was fun yet painful doing all the research work but it helped me understand a lot of things about programming and I hope it will help you too.

Without any mode delay, let's dive right into the [first challenge](/bandit/README.md)
