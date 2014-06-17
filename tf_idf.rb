require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'
require 'rubygems'
require 'k_means'
require 'ostruct'
class Integer
  N_BYTES = [42].pack('i').size
  N_BITS = N_BYTES * 16
  MAX = 2 ** (N_BITS - 2) - 1
  MIN = -MAX - 1
end
class TfIdf
  attr_accessor :filename,:tokens,:sentences,:global_res #this is a hash, every key stores a list
  def initialize(filename)
     @filename=filename
     @global_res={}
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
  def cal_idf(word)
    ct=0
    for sent in @sentences
      if sent.include? word
        ct+=1
      end
    end
    ct
  end
  def get_single_sentence_list(sent)
    sent_lis=sent.split(/,|:|\.|\"|\'|\s/)
    sent_lis.map {|x| sent_lis.delete(x) if x.strip().length==0 or x==nil}
    sent_lis
  end
  def cal_tfidf
    sentence_hash={}
    for sent in @sentences
      tmp_tfidf=0
      sent_lis=get_single_sentence_list(sent)
      for word in sent_lis
         ct=sent.scan(/#{word}/).length
         idf=cal_idf(word)
         tmp_tfidf+=ct*Math.log(@sentences.size/idf,2)
      end
      sentence_hash[sent]=tmp_tfidf
    end
    sentence_hash
  end
  def kmeans(k)
    res_hash=cal_tfidf()
    tmp_data=res_hash.values
    data=[]
    for i in tmp_data
      data.push([i])
    end
    kmeans = KMeans.new(data, :centroids => k)

    #puts kmeans.nodes.inspect
  #  puts res_hash.inspect
    for i in kmeans.nodes
      res_hash.each do |k,v|
        if res_hash[k]==i.position[0]
          tmp_sent=OpenStruct.new
          tmp_sent.sentence=k
          tmp_sent.best_distance=i.best_distance
          if !@global_res[i.closest_centroid.position].nil?
            @global_res[i.closest_centroid.position].push(tmp_sent)
          else
            @global_res[i.closest_centroid.position]=[]
            @global_res[i.closest_centroid.position].push(tmp_sent)
          end
        end
      end
    end
  end
end
tfidf=TfIdf.new("N09-1008.txt")
tfidf.tokenize
tfidf.sentenize
tfidf.kmeans(5)
ans_sent_lis=[]
tfidf.global_res.each do |k,v|
  tmp_min=Integer::MAX
  tmp_ostruct=OpenStruct.new
  for i in v
    if i.best_distance<tmp_min
      tmp_min=i.best_distance
      tmp_ostruct=i
    end
  end
  ans_sent_lis.push(tmp_ostruct.sentence)
end
for i in ans_sent_lis
  puts i+"."
end


