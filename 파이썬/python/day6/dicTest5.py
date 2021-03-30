score_of_class = {
    "class1": (77, 85, 67, 80, 90),
    "class2": (60, 80, 75, 98, 82),
    "class3": (72, 77, 65, 83, 95),
    "class4": (92, 70, 85, 67, 88)
}

print("class3 :", score_of_class["class3"])
for key, value in score_of_class.items():
    print("[", key, "반]")
    print("총점 :", sum(value))
    print("최고점 :", max(value))
    print("최저점 :", min(value))
