"""Identity operators

@see: https://www.w3schools.com/python/python_operators.asp

Identity operators are used to compare the objects, not if they are equal, but if they are actually
the same object, with the same memory location.
"""


def test_identity_operators():
    """Identity operators"""

    # Let's illustrate identity operators based on the following lists.
    first_fruits_list = ["apple", "banana"]
    second_fruits_list = ["apple", "banana"]
    third_fruits_list = first_fruits_list

    assert third_fruits_list is third_fruits_list
    assert third_fruits_list is not second_fruits_list
    assert third_fruits_list == second_fruits_list
