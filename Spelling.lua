local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local SubmitAnswer = Remotes:WaitForChild("SubmitAnswer")

game.DescendantAdded:Connect(function(obj)
	if obj:IsA("Sound") then
		task.defer(function()
			for attempt = 1, 10 do
				local soundId = obj.SoundId
				local assetId = soundId:match("%d+")

				if assetId then
					local success, info = pcall(function()
						return MarketplaceService:GetProductInfo(tonumber(assetId))
					end)

					if success and info and info.Name then
						local name = info.Name
						name = name:match("^(.-)%s*%(%d+%)$") or name
						name = name:lower():gsub("%s+", "") -- hapus spasi

						-- Kirim huruf satu per satu
						for i = 1, #name do
							local huruf = name:sub(i, i)
							SubmitAnswer:FireServer({ "Type", huruf })
							task.wait(0.2)
						end

						task.wait(0.3)
						SubmitAnswer:FireServer({ "Submit", name })
					end
					break
				end
			end
		end)
	end
end)
