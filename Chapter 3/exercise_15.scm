;Exercise 3.15.  Draw box-and-pointer diagrams to explain the effect of `set-to-wow!`
;on the structures z1 and z2 above.

"Here are z1 and z2 pre-wow:

z1 -> [|][|]
       |  |
       v  v
      [|][-]-->[|][/]
       |        |
       v        v
       a        b

z2 -> [|][-]-->[|][-]-->[|][/]
       |        |        |  
       |        v        v 
       |        a        b
       |        ^        ^
       |        |        |
       |-------[|][-]-->[|][/]


Here is z1 post-wow:

z1 -> [|][|]
       |  |
       v  v
      [|][-]-->[|][/]
       |        |
       v        v
      wow       b
"