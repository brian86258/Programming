# This folder will organize all DS-related programming files
##[Useful Sources](https://github.com/alexeygrigorev/data-science-interviews?fbclid=IwAR3L7vS_omchABDcz07WsmpkCJ8vW9gccmhas152rqOuhZlDJiNYTDyixnc)

## Following will be some questions 
Now, let’s start with the actual questions. First, we’ll cover SQL.
### SQL
A data scientist is supposed to be fluent with SQL: the data is stored in databases, so being able to extract this data from there is essential in our job. That’s why data scientists are checked for knowledge of SQL.
Suppose we have the following schema with two tables: Ads and Events
Ads(ad_id, campaign_id, status)
Events(event_id, ad_id, source, event_type, date, hour)

Each ad can be active or inactive, and this is reflected in the status field.
There are different event types:
impression (ad is shown to the user)
click (the user clicked on the ad)
conversion (the user installed the app from the advertisement)
We want to write a couple of queries to extract data from these tables. Write SQL queries to extract the following information:
1) The number of active ads.
2) All active campaigns. A campaign is active if there’s at least one active ad.
3) The number of active campaigns.
4) The number of events per each ad — broken down by event type.

5) The number of events over the last week per each active ad — broken down by event type and date (most recent first).

6) The number of events per campaign — by event type.

7) The number of events over the last week per each campaign — broken down by date (most recent first).

8) CTR (click-through rate) for each ad. CTR = number of impressions / number of clicks.

9) CVR (conversion rate) for each ad. CVR = number of clicks / number of installs.

10) CTR and CVR for each ad broken down by day and hour (most recent first).

11) CTR for each ad broken down by source and day
Next, we’ll look at coding challenges.
### Coding (Python)
A data scientist is expected to be able to program. Usually, in Python, but sometimes in R or Java or something else.
That’s why it’s quite likely that you’ll get questions that check the ability to program a simple task. These tasks often aim at checking if candidates know the basics of Python, such as loops, simple data structures (lists, sets, dictionaries), and strings.
Some of these questions may look simple for experienced developers. That’s on purpose — they are needed to check the basics only. However, you can get multiple questions of increasing difficulty during one round.
So, let’s start. We’ll begin with the most famous simple question: FizzBuzz.
1) FizzBuzz. Print numbers from 1 to 100
If it’s a multiplier of 3, print “fizz”
If it’s a multiplier of 5, print “buzz”
If both 3 and 5 — “fizzbuzz”
Otherwise, print the number itself
Example of output: 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, Fizz Buzz, 31, 32, Fizz, 34, Buzz, Fizz, …
2) Factorial. Calculate a factorial of a number
factorial(5) = 5! = 1 * 2 * 3 * 4 * 5 = 120
factorial(10) = 10! = 1 * 2 * 3 * 4 * 5 * 6 * 7 * 8 * 9 * 10 = 3628800
3) Mean. Compute the mean of number in a list
mean([4, 36, 45, 50, 75]) = 42
mean([]) = NaN
(usefloat('NaN') )

4) STD. Calculate the standard deviation of elements in a list.
std([1, 2, 3, 4]) = 1.29
std([1]) = NaN
std([]) = NaN

5) RMSE. Calculate the RMSE (root mean squared error) of a model. The function takes in two lists: one with actual values, one with predictions.
rmse([1, 2], [1, 2]) = 0
rmse([1, 2, 3], [3, 2, 1]) = 1.63

6) Remove duplicates. Remove duplicates in list. The list is not sorted and the order of elements from the original list should be preserved.
[1, 2, 3, 1] ⇒ [1, 2, 3]
[1, 3, 2, 1, 5, 3, 5, 1, 4] ⇒ [1, 3, 2, 5, 4]
7) Count. Count how many times each element in a list occurs.
[1, 3, 2, 1, 5, 3, 5, 1, 4] ⇒
1: 3 times
2: 1 time
3: 2 times
4: 1 time
5: 2 times
8) Palindrome. Is string a palindrome? A palindrome is a word that reads the same backward as forwards.
“ololo” ⇒ Yes
“cafe” ⇒ No
9) Counter. We have a list with identifiers of the form “id-SITE”. Calculate how many ids we have per site.

10) Top counter. We have a list with identifiers of form “id-SITE”. Show the top 3 sites. You can break ties in any way you want.

11) RLE. Implement RLE (run-length encoding): encode each character by the number of times it appears consecutively.
'aaaabbbcca' ⇒[('a', 4), ('b', 3), ('c', 2), ('a', 1)]
(note that there are two groups of 'a')
12) Jaccard. Calculate the Jaccard similarity between two sets: the size of the intersection divided by the size of the union.
jaccard({'a', 'b', 'c'}, {'a', 'd'}) = 1 / 4

13) IDF. Given a collection of already tokenized texts, calculate the IDF (inverse document frequency) of each token.
input example: [['interview', 'questions'], ['interview', 'answers']]

Where:
t is the token,
n(t) is the number of documents that t occurs in,
N is the total number of documents
14) PMI. Given a collection of already tokenized texts, find the PMI (pointwise mutual information) of each pair of tokens. Return top 10 pairs according to PMI.
input example: [['interview', 'questions'], ['interview', 'answers']]
PMI is used for finding collocations in a text — things like “New York” or “Puerto Rico”. For two consecutive words, the PMI between them is:

The higher the PMI, the more likely these two tokens form a collection. We can estimate PMI by counting:

Where:
N is the total number of tokens in the text,
c(t1, t2) is the number of times t1 and t2 appear together,
c(t1) and c(t2) — the number of times they appear separately.
These questions can also be used to check the knowledge of NumPy — some of them may be solved in NumPy with just one or two lines.
Next, we’ll look at a slightly different type of coding tasks — algorithmic questions.


### Algorithmic Questions
In the previous section, we looked at coding questions. These questions have quite detailed instructions on what to do — and the candidates are expected to translate these instructions into Python code.
There’s a different kind of questions, with no detailed instructions. For these questions, the candidates should be able to figure out the solution on their own — of course, with hints.
The goal of these problems is to “see how candidates think” and also check if they know algorithms and data structures. Sometimes, these questions are brain teasers, and sometimes they are questions from a textbook on algorithms. I call these types of questions “algorithmic”.
I’m not a fun of such coding problems, but there are many companies that ask them. So let’s cover some of them.
1) Two sum. Given an array and a number N, return True if there are numbers A, B in the array such that A + B = N. Otherwise, returnFalse.
[1, 2, 3, 4], 5 ⇒True
[3, 4, 6], 6 ⇒False
2) Fibonacci. Return the n-th Fibonacci number, which is computed using this formula:
F(0) = 0
F(1) = 1
F(n) = F(n-1) + F(n-2)
The sequence is: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, …
3) Most frequent outcome. We have two dice of different sizes (D1 and D2). We roll them and sum their face values. What are the most probable outcomes?
6, 6 ⇒[7]
2, 4 ⇒ [3, 4, 5]
4) Reverse a linked list. Write a function for reversing a linked list.
The definition of a list node: Node(value, next)
Example: a -> b -> c ⇒ c -> b -> a
5) Flip a binary tree. Write a function for rotating a binary tree.
The definition of a tree node: Node(value, left, right)

6) Binary search. Return the index of a given number in a sorted array or -1 if it’s not there.
[1, 4, 6, 10], 4 ⇒ 1
[1, 4, 6, 10], 3 ⇒ -1
7) Deduplication. Remove duplicates from a sorted array.
[1, 1, 1, 2, 3, 4, 4, 4, 5, 6, 6] ⇒ [1, 2, 3, 4, 5, 6]
8) Intersection. Return the intersection of two sorted arrays.
[1, 2, 4, 6, 10], [2, 4, 5, 7, 10] ⇒[2, 4, 10]
9) Union. Return the union of two sorted arrays.
[1, 2, 4, 6, 10], [2, 4, 5, 7, 10] ⇒[1, 2, 4, 5, 6, 7, 10]
10) Addition. Implement the addition algorithm from school. Suppose we represent numbers by a list of integers from 0 to 9:
12 is [1, 2]
1000 is [1, 0, 0, 0]
Implement the “+” operation for this representation
[1, 1] + [1] ⇒ [1, 2]
[9, 9] + [2] ⇒[1, 0, 1]
11) Sort by custom alphabet. You’re given a list of words and an alphabet (e.g. a permutation of Latin alphabet). You need to use this alphabet to order words in the list.
Example (taken from here):
Words: ['home', 'oval', 'cat', 'egg', 'network', 'green']
Dictionary: 'bcdfghijklmnpqrstvwxzaeiouy'
Output: ['cat', 'green', 'home', 'network', 'egg', 'oval']
12) Check if a tree is a binary search tree. In BST, the element in the root is:
Greater than or equal to the numbers on the left
Less than or equal to the number on the right
