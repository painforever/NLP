require 'ostruct'
class Vector_Cosine_Method_R
  attr_accessor :filename,:tokens,:sentences,:new_vectors,:global_res
  def initialize(filename)
    @filename=filename
    @global_res=[]
  end


  def read_file
    fp=File.open(@filename,"r")
    content=fp.read
    content
  end

  def sentenize
    content=read_file
    sentence=content.split(/\.|\?|!/)
    @sentences=sentence
  end

  def tokenize
    content=read_file
    word_list=content.split(" ")
    word_list.map {|word| word.gsub!(/,|:|\.|\"|\'|\s/,"")}
    hash={}
    for word in word_list
      if hash[word].nil?
        hash[word]=1
      else hash[word]+=1
      end
    end
    @tokens=hash
  end

  def get_new_single_vector(sent)
    res_vector={}
    @tokens.each do |k,v|
      ct=sent.scan(/#{k}/).length
      res_vector[k]=ct
    end
    res_vector.sort {|a,b| a[0]<=>b[0]}
    res_vector
  end

  def construct_vector
    new_vectors=[]
    for sent in @sentences
      member=OpenStruct.new
      member.sentence=sent
      tmp_hash=get_new_single_vector(sent)
      member.new_vector=tmp_hash
      new_vectors.push(member)
    end
    @new_vectors=new_vectors
    new_vectors
  end

  def get_dot_multiple(v1,v2)
    res=0
    v1.each do |k,v|
      res+=v1[k]*v2[k]
    end
    res
  end

  def get_mod_product(v1,v2)
    res=0
    res2=0
    v1.each do |k,v|
      res+=v1[k]**v1[k]
      res2+=v2[k]**v2[k]
    end
    Math.sqrt(res)*Math.sqrt(res2)
  end

  def get_first_from_sorted_hash(hash)
    index=0
    res=""
    hash.each do |k,v|
       if index>=1
         res=k
       end
      index+=1
    end
    res
  end
  def get_answer(k)#get the final answer
    for i in 0...k
       answer={}
       for v in @new_vectors
         #v.distance=get_dot_multiple(v.new_vector,@tokens)/get_mod_product(v.new_vector,@tokens)
         answer[v.sentence]=get_dot_multiple(v.new_vector,@tokens)/get_mod_product(v.new_vector,@tokens)
       end
       answer=answer.sort_by {|k,v| v}
       top1_sent_vec=get_new_single_vector(get_first_from_sorted_hash(answer))#top1_sent includes all the words
       #now we need to push it to the global_res
       top1_sent=get_first_from_sorted_hash(answer)
       @global_res.push(top1_sent)
       #delete the picked top1_sent from @new_vector which is a list
       for member in @new_vectors
         if member.sentence==top1_sent
           @new_vectors.delete(member)
           break
         end
       end
       #decrease the @token hash
       @tokens.each do |k,v|
         @tokens[k]-=top1_sent_vec[k]
         if @tokens[k]<0
           @tokens[k]=0  #in case negetive values appear
         end
       end
     end
  end
end
a=Vector_Cosine_Method_R.new("N09-1008.txt")
a.tokenize
a.sentenize
a.construct_vector
a.get_answer(10)
for i in a.global_res
  puts i
end



