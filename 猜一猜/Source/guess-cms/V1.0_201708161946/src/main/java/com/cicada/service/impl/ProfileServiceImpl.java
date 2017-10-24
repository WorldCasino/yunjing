package com.cicada.service.impl;

import org.springframework.stereotype.Service;

import com.cicada.mapper.ProfileMapper;
import com.cicada.pojo.Profile;
import com.cicada.service.IProfileService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

@Service
public class ProfileServiceImpl extends ServiceImpl<ProfileMapper, Profile> implements IProfileService{

	@Override
	public void updateImgById(Long userId, String filePath) {
		Profile profile = new Profile();
		profile.setUserId(userId);
		EntityWrapper<Profile> wrapper = new EntityWrapper<Profile>(profile);
		Profile profile1 = new Profile();
		profile1.setAddress(filePath);
		this.update(profile1, wrapper);
	}

}
