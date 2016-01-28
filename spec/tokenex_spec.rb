require 'spec_helper'

describe Tokenex do
  def tokenex
    api_base_url = ENV["TOKENEX_API_BASE_URL"]
    token_ex_id = ENV["TOKENEX_ID"]
    api_key = ENV["TOKENEX_API_KEY"]
    Tokenex::Environment.new(api_base_url, token_ex_id, api_key)
  end
  
  def valid_ccnum
    4242424242424242
  end
  
  def invalid_ccnum
    1234567812345678
  end
  
  def invalid_token
    'abcdefg'
  end
  
  def token
    tokenex.token_from_ccnum(valid_ccnum)
  end
  
  def ccnum
    tokenex.ccnum_from_token(token)
  end

  it 'has a version number' do
    expect(Tokenex::VERSION).not_to be nil
  end

  it 'tokenizes a credit card' do
    expect(token).not_to be nil
  end
  
  it 'detokenizes a credit card' do
    expect(ccnum).not_to be nil
  end
  
  it 'returns valid data' do
    expect(valid_ccnum === ccnum.to_i).to be true
  end
  
  it 'handles bad credit cards' do
    expect { tokenex.token_from_ccnum(invalid_ccnum) }.to throw_symbol(:tokenex_invalid_ccnum)
  end
  
  it 'handles bad tokens' do
    expect { tokenex.ccnum_from_token(invalid_token) }.to throw_symbol(:tokenex_invalid_token)
  end
end
