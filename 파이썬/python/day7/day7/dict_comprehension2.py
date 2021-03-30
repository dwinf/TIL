score_tuples = [('math', 90), ('history', 80), ('english', 95), ('computer engineering', 100), ('science', 60)]
score_dict = dict(score_tuples)
print(score_dict)

score_dict = {t[0]: t[1] for t in score_tuples}
print(score_dict)

score_dict = {k: v for k, v in score_tuples}
print(score_dict)

score_dict = {k: v for k, v in score_tuples if len(k) > 5}
print(score_dict)

score_dict = {k: v for k, v in score_tuples if v >= 90}
print(score_dict)

score_dict = {k: v for k, v in score_tuples if v < 70}
print(score_dict)
