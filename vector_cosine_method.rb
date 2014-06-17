require 'ostruct'
class Vector_Cosine_Method
  attr_accessor :filename,:tokens,:sentences,:new_vectors
  def initialize(filename)
    @filename=filename
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

  def get_answer(k)#get the final answer
    answer={}
    for v in @new_vectors
       #v.distance=get_dot_multiple(v.new_vector,@tokens)/get_mod_product(v.new_vector,@tokens)
       answer[v.sentence]=get_dot_multiple(v.new_vector,@tokens)/get_mod_product(v.new_vector,@tokens)
    end
    answer=answer.sort_by {|k,v| v}
    index=0
    res=[]
    answer.each do |k,v|
      res.push(k)
      if index>=k
        return res
      end
      index+=1
    end
  end
end
a=Vector_Cosine_Method.new("sy.txt")
a.tokenize
a.sentenize
a.construct_vector
a.get_answer(3)



