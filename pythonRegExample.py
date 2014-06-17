import tweepy
import re
# p=re.compile(r"dfsdfs{(.*?)}\w+{(.*?)}",re.IGNORECASE)
# print p.search("{group 1}XX{group 2}").group(2)
# p = re.compile(r"(\w+\s+)")
# m=p.match("string goes here ")
#


# m = p.findall('string goes here ')
#
# if m:
#   for i in m:
#       print i
#       pass


# p = re.compile( '(blue|white|red)')
# print p.sub( 'colour', 'blue socks and red shoes')

# phone = "2004-959-559 # This is Phone Number"
#
# # Delete Python-style comments
# num = re.sub(r'#.*$', "", phone)
# print "Phone Num : ", num
#
# # Remove anything other than digits
# num = re.sub(r'\D', "", phone)
# print "Phone Num : ", num


# p=re.compile(r'\d+')
# m=p.search('wocao nima ya dia hua shi 1144234 manyile ba')
# if m:
#     print m.group()
# p=re.compile(r'\d+')
# m=p.match('wocao nima ya dia hua shi 1144234 manyile ba')
# if m:
#     print m.group()


p=re.compile(r'\d+')
m=p.match('132234 wocao nima ya dia hua shi 1144234 manyile ba')
if m:
    print m.group()