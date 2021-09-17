

arr = []

def modify_array(arr2):
    # will modify arr
    # arr2 += [3,3,3,3]
    # will also modify
    arr2.extend([4,4,4,4,4])

    print('local arr2', arr2)

def function1(arr):

    
    modify_array(arr)
    print('int function1',arr)

function1(arr)
print(arr)