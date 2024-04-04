from collections import Counter

RULES = [
    (1000, Counter([1, 1, 1])),
    (600, Counter([6, 6, 6])),
    (500, Counter([5, 5, 5])),
    (400, Counter([4, 4, 4])),
    (300, Counter([3, 3, 3])),
    (200, Counter([2, 2, 2])),
    (100, Counter([1])),
    (50, Counter([5]))
]

def score(dice):
    dice = Counter(dice)
    rule = next((r for r in RULES if r[1] <= dice), None)
    if rule is None: return 0
    return rule[0] + score(dice - rule[1])
