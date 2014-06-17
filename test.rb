module Math
  def self.max(a, b)
    a > b ? a : b
  end

  def self.min(a, b)
    a < b ? a : b
  end
end
summary1=""
summary2=""
def split_into_sentence_list(content)
  sentence_list=content.split(/\.|\?|!/)
  sentence_list
end
def split_into_word_list(summary)
  summ_lis=summary.split(/\.|\s|\,/)
  new_lis=[]
  for i in summ_lis
     if i.chomp.size>0
       new_lis.push(i)
     end
  end
  new_lis
end

def construct_word_hash(sent1_hash, sent2_hash, word_list)
  word_list.each {|k|
    if sent1_hash[k].nil?
      sent1_hash[k]=1
    else
      sent1_hash[k]+=1
    end
    if sent2_hash[k].nil?
      sent2_hash[k]=0
    end
  }
  return sent1_hash,sent2_hash
end
#pass 2 sentences directly and make them have the same feature in this function
#def cal_distance(sent1,sent2)
#  sent1_hash={}
#  sent2_hash={}
#  sent1_word_list=split_into_word_list(sent1)
#  sent2_word_list=split_into_word_list(sent2)
#  sent1_hash,sent2_hash=construct_word_hash(sent1_hash,sent2_hash,sent1_word_list)
#  sent1_hash,sent2_hash=construct_word_hash(sent2_hash,sent1_hash,sent2_word_list)
#  distance=0
#  sent1_hash.each do |k,v|
#    distance+=((sent1_hash[k]-sent2_hash[k])**2)
#  end
#  Math.sqrt(distance)
#end

def get_dot_mul(sent1,sent2)
  res=0
  sent1.each do |k,v|
    res+=(sent1[k]*sent2[k])
  end
  res
end

def get_mod(sent)
  res=0
  sent.each do |k,v|
     res+=(sent[k]**2)
  end
  Math.sqrt(res)
end

def cal_distance(sent1,sent2)
  sent1_hash={}
  sent2_hash={}
  sent1_word_list=split_into_word_list(sent1)
  sent2_word_list=split_into_word_list(sent2)
  sent1_hash,sent2_hash=construct_word_hash(sent1_hash,sent2_hash,sent1_word_list)
  sent1_hash,sent2_hash=construct_word_hash(sent2_hash,sent1_hash,sent2_word_list)
  distance=0
  distance=get_dot_mul(sent1_hash,sent2_hash)/(get_mod(sent1_hash)*get_mod(sent2_hash))
  distance
end

def evaluation(summary1,summary2)
  sent1_lis=split_into_sentence_list(summary1)
  sent2_lis=split_into_sentence_list(summary2)
  min=Math.min(sent1_lis.size,sent2_lis.size)
  sent1_lis=sent1_lis[0...min];sent2_lis=sent2_lis[0...min]
  sum=0
  for i in sent2_lis
    sent_del=i;max=0
    for j in sent1_lis
       tmp_max=cal_distance(i,j)
       if tmp_max>max
         max=tmp_max
         sent_del=j
       end
    end
    sum+=max
    sent1_lis.delete(sent_del)
  end
  sum
end
def read_file(file_path)
  fp=File.open(file_path,"r")
  fp.read
end
summary1=read_file("sy.txt")
summary2=read_file("sy2.txt")
print evaluation(summary1,summary2)



